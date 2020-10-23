# SwiftyNarou

SwiftyNarou is a Swift wrapper around the Narou API. In addition to supporting all of the API's function calls, SwiftyNarou also enables the user to retrieve novel contents by providing an ncode. Inspired by narou4j by nshiba (https://github.com/nshiba/narou4j).

## Installation
### Cocoapods
Add `pod 'SwiftyNarou'` to your Podfile and run `pod install`.
To use, `import SwiftyNarou`.

## Usage:
### Fetch parsed results of querying the Narou API
As of version 1.1.0, you _must_ specify the .JSON as the file format because only the JSON parser has been implemented.
```
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
Narou.fetchNarouApi(request) { data, error in
  if err != nil, let res: [NarouResponse] = data {
    // do something
  }
}
```

### Fetch raw results of querying the Narou API
`fetchNarouApiRaw`, does not dispatch to the main queue, so any completion logic must include a dispatch.
```
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
Narou.fetchNarouApiRaw(request) { data, error in
  if err != nil, let res: [NarouResponse] = data {
    DispatchQueue.main.async {
      // do something
    }
  }
}
```

### Fetch a table of contents page:
```
let ncode = "n12345"
Narou.fetchNovelIndex(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```

### Fetch contents of a section:
```
let ncode = "n12345"
Narou.fetchSectionContent(ncode) { data, error in
  if err != nil, let novelIndex = data {
    // do something
  }
}
```
