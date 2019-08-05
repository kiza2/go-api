package main

/*
To run:
go run main.go

Goto:
http://localhost:3000/

To build exe
go build


git add --all
git commit -m "added dockerfile"
git push

*/

import (
	"net/http"

	"github.com/go-chi/chi"
)

func main() {
	r := chi.NewRouter()
	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("welcome"))
	})
	http.ListenAndServe(":3000", r)
}
