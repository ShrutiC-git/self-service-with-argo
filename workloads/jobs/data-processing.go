package main

import (
	"fmt"
	"math/rand/v2"
	"time"
)

func main() {
	fmt.Printf("Data processing job started at %v\n", time.Now())
	for task := 1; task <= 5; task++ {
		processTask(task)
	}
	fmt.Printf("Data processing job completed at %v\n", time.Now())
}

func processTask(task int) {
	duration := rand.IntN(3) + 1
	fmt.Printf("Processing task %d for %d seconds\n", task, duration)
	time.Sleep(time.Duration(duration) * time.Second)
	fmt.Printf("Task %d processed\n", task)
}
