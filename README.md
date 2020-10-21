# SwiftyNarou

SwiftyNarou is a Swift wrapper around the Narou API. In addition to supporting all of the API's function calls, SwiftyNarou also enables the user to retrieve novel contents by providing an ncode. Inspired by narou4j by nshiba (https://github.com/nshiba/narou4j).

## Installation
### Cocoapods
Add `pod 'SwiftyNarou'` to your Podfile and run `pod install`.
To use, `import SwiftyNarou`.

## Usage:
### Fetch result of querying the Narou API
As of version 1.0.1, you _must_ specify the .JSON as the file format.
Gzip compression also does not work.
```
let narou = Narou()
let request = NarouRequest(
  bigGenre: .fantasy,
  ... (more request params)
  responseFormat: NarouResponseFormat(
    fileFormat: .JSON, // this is mandatory for now.
    fields: [.ncode, .title, .author, ...] // select columns to return (highly recommended)
    limit: 10, // recommended
    ... (more output formatting)
  )
)
narou.fetchNarouApi(request) { data, error in
  if err != nil, let res: [NarouResponse] = data {
    // do something
  }
}
```

### Fetch a table of contents page:
```
let ncode = "n12345"
let narou = Narou()
narou.fetchNovelIndex(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```

### Fetch contents of a section:
```
let ncode = "n12345"
let narou = Narou()
narou.fetchSectionContent(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```
