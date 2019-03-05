GO_FOLDERS=./cmd/... ./internal/... ./pkg/...

go-fmt:
	go fmt $(GO_FOLDERS)

go-vet:
	go vet $(GO_FOLDERS)

go-test:
	go test -count=1 $(GO_FOLDERS)

go-lint:
	golint -set_exit_status $(GO_FOLDERS)

go-fmt-check: go-fmt
	@if [ -z "`git status --porcelain`" ]; then exit 0; else echo "please run \`make go-fmt\` and commit the result" && exit 1; fi

test-go: go-vet go-test go-lint go-fmt-check

#vendors modules for go modules
vendor-modules:
	go mod vendor -v

# update modules with current imports
tidy-modules:
	go mod tidy -v

update-deps:
	go get -u

clean: update-deps tidy-modules vendor-modules