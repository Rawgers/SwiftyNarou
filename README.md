# SwiftyNarou

SwiftyNarou is a Swift wrapper around the Narou API. In addition to supporting all of the API's function calls, SwiftyNarou also enables the user to retrieve novel contents by providing an ncode. Inspired by narou4j by nshiba (https://github.com/nshiba/narou4j).

# Usage:
## Fetch a table of contents page:
```
let ncode = "n12345"
let narou = Narou()
narou.fetchNovelIndex(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```

## Fetch contents of a section:
```
let ncode = "n12345"
let narou = Narou()
narou.fetchSectionContent(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```
