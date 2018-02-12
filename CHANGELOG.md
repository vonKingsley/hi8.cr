# Version 0.1.1

- **DEPRECATED** **BREAKING CHANGE** cassette_libarary_dir is now called cabinet_shelf.
```crystal
  HI8.configure do |conf|
    conf.cabinet_shelf = "new/shelf"
  end
```
- Added ability to create nested dirs with the cassette name
   - "named"
   - "path/named"
   - "/path/named"
   - "nested/path/named"
   - "/nested/path/named"
