package main

import "syscall/js"

func main() {
	js.Global().Set("svca", js.FuncOf(func(this js.Value, args []js.Value) interface{} {
		return "SVCA deterministic module OK"
	}))
	select {}
}
