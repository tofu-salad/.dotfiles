package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"
)

type TmuxSessionError struct {
	SessionName  string
	SelectedPath string
	Err          error
}

func (e *TmuxSessionError) Error() string {
	return fmt.Sprintf("Error creating/attaching to tmux session:\nSelected Name: %s\nSelected Path: %s\nError: %v", e.SessionName, e.SelectedPath, e.Err)
}

func main() {
	selected, err := selectDirectory()
	if err != nil {
		fmt.Println(err)
		return
	}
	err = createSession(selected)
	if err != nil {
		if sessionErr, ok := err.(*TmuxSessionError); ok {
			fmt.Println(sessionErr.Error())
		} else {
			fmt.Println("Unexpected error:", err)
		}
	}
}

func selectDirectory() (string, error) {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		return "", err
	}
	searchPaths := []string{
		// path.Join(homeDir, "code"),
		path.Join(homeDir, "Code"),
	}
	var selectedPath string
	if len(os.Args) == 2 {
		selectedPath = os.Args[1]
	} else {
		selectedPath, err = fdFzfSelect(searchPaths...)
		if err != nil {
			return "", err
		}
	}
	return selectedPath, nil

}
func fdFzfSelect(paths ...string) (string, error) {
	var fd string
	args := append([]string{".", "-d", "1", "-t", "d"}, paths...)

	if _, err := exec.LookPath("fd"); err == nil {
		fd = "fd"
	}
	if _, err := exec.LookPath("fdfind"); err == nil {
		fd = "fdfind"
	}
	fdCmd := exec.Command(fd, args...)
	fdCmd.Stderr = os.Stderr

	fzfCmd := exec.Command("fzf")
	fzfCmd.Stderr = os.Stderr

	fzfInput, err := fdCmd.StdoutPipe()
	if err != nil {
		return "", err
	}
	fzfCmd.Stdin = fzfInput

	var stdout bytes.Buffer
	fzfCmd.Stdout = &stdout

	if err := fzfCmd.Start(); err != nil {
		return "", err
	}

	if err := fdCmd.Start(); err != nil {
		return "", err
	}

	if err := fdCmd.Wait(); err != nil {
		return "", err
	}

	if err := fzfCmd.Wait(); err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 1 {
			return "", nil
		}
		return "", nil
	}

	var selected string
	scanner := bufio.NewScanner(&stdout)
	for scanner.Scan() {
		selected = scanner.Text()
		break
	}

	if err := scanner.Err(); err != nil && err != io.EOF {
		return "", err
	}

	return selected, nil
}

func createSession(selectedPath string) error {
	selectedName := strings.ReplaceAll(filepath.Base(selectedPath), ".", "_")

	// Check if tmux is already running
	if os.Getenv("TMUX") == "" && !isTmuxRunning() {
		// If tmux is not running, create a new session
		createCmd := exec.Command("tmux", "new-session", "-s", selectedName, "-c", selectedPath)
		err := createCmd.Run()
		if err != nil {
			return &TmuxSessionError{
				SessionName:  selectedName,
				SelectedPath: selectedPath,
				Err:          fmt.Errorf("error creating tmux session: %w", err),
			}
		}
		return nil
	}

	// Check if the session already exists
	checkCmd := exec.Command("tmux", "has-session", "-t", selectedName)
	err := checkCmd.Run()
	if err != nil {
		// If the session doesn't exist, create a new detached session
		createCmd := exec.Command("tmux", "new-session", "-d", "-s", selectedName, "-c", selectedPath)
		err := createCmd.Run()
		if err != nil {
			return &TmuxSessionError{
				SessionName:  selectedName,
				SelectedPath: selectedPath,
				Err:          fmt.Errorf("error creating tmux session: %w", err),
			}
		}
	}

	// Attach to the selected session or switch to a new tmux session
	if os.Getenv("TMUX") == "" {
		// If not running inside tmux, create a new tmux session and switch to it
		switchCmd := exec.Command("tmux", "new-session", "-A", "-s", selectedName)
		switchCmd.Stdin = os.Stdin
		switchCmd.Stdout = os.Stdout
		switchCmd.Stderr = os.Stderr

		err = switchCmd.Run()
		if err != nil {
			return &TmuxSessionError{
				SessionName:  selectedName,
				SelectedPath: selectedPath,
				Err:          fmt.Errorf("error switching to tmux session: %w", err),
			}
		}
	} else {
		// If running inside tmux, switch to the selected session
		attachCmd := exec.Command("tmux", "switch-client", "-t", selectedName)
		attachCmd.Stdin = os.Stdin
		attachCmd.Stdout = os.Stdout
		attachCmd.Stderr = os.Stderr

		err = attachCmd.Run()
		if err != nil {
			return &TmuxSessionError{
				SessionName:  selectedName,
				SelectedPath: selectedPath,
				Err:          fmt.Errorf("error attaching to tmux session: %w", err),
			}
		}
	}

	return nil
}

func isTmuxRunning() bool {
	cmd := exec.Command("pgrep", "tmux")
	err := cmd.Run()
	return err == nil
}
