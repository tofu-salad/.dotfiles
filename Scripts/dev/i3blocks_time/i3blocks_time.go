package main

import (
	"fmt"
	"strings"
	"time"
)

func main() {
	currentTime := time.Now()
    formattedTime := currentTime.Format(" Monday ") + dayWithSuffix(currentTime.Day()) + currentTime.Format("15:04")
	fmt.Println(strings.TrimSpace(formattedTime))
}

func dayWithSuffix(day int) string {
	suffix := "th"
	switch day {
	case 1, 21, 31:
		suffix = "st"
	case 2, 22:
		suffix = "nd"
	case 3, 23:
		suffix = "rd"
	}
	return fmt.Sprintf("%d%s ", day, suffix)
}
