# Return a list of files from within zips which match a pattern

\`find_files_from_zip\` looks inside one zipfile,
\`find_files_from_zips\` looks for all zipfiles in a directory

## Usage

``` r
find_files_from_zips(root_directory, tag, file_pattern = "*.zip$")

find_files_from_zip(zipfile, tag)
```

## Arguments

- root_directory:

  Directory to search

- tag:

  Tag in txt filenames within zips

- file_pattern:

  Pattern zip files must match

## Value

A named list of txt/tsv files within each zip
