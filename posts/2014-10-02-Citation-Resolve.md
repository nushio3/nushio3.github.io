---
title: An update on citation-resolve
author: Takayuki Muranushi
tags: Haskell, Academic Writing, citation-resolve
---

A while ago I've implemented a Haskell package called 
[citation-resolve](http://hackage.haskell.org/package/citation-resolve).
that can convert document IDs such as DOIs, ISBNs, arXiv IDs to reference data.

Recently, Adam Harries has proposed [an enhancement](https://github.com/nushio3/citation-resolve/pull/1)
that allows easy access to the error message (if any) of the retrieval process.

``` haskell
λ> import Text.CSL.Input.Identifier
λ> resolveEitherDef "arXiv:1409.7395"
Right (Reference {refId = "2014arXiv1409.7395H", refType = article-journal, author = [P. F. Hopkins], editor = [], translator = [], recipient = [], interviewer = [], composer = [], director = [], illustrator = [], originalAuthor = [], containerAuthor = [], collectionEditor = [], editorialDirector = [], reviewedAuthor = [], issued = [RefDate {year = "2014", month = "sep", season = "", day = "", other = "", circa = ""}], eventDate = [], accessed = [], container = [], originalDate = [], submitted = [], title = "GIZMO: A New Class of Accurate, Mesh-Free Hydrodynamic Simulation Methods", titleShort = "GIZMO", reviewedTitle = "", containerTitle = "ArXiv e-prints", volumeTitle = "", collectionTitle = "", containerTitleShort = "", collectionNumber = "", originalTitle = "", publisher = "", originalPublisher = "", publisherPlace = "", originalPublisherPlace = "", authority = "", jurisdiction = "", archive = "", archivePlace = "", archiveLocation = "", event = "", eventPlace = "", page = "", pageFirst = "", numberOfPages = "", version = "", volume = "", numberOfVolumes = "", issue = "", chapterNumber = "", medium = "", status = "", edition = "", section = "", source = "", genre = "academic journal", note = "", annote = "", abstract = "", keyword = "", number = "", references = "", url = "http://adsabs.harvard.edu/abs/2014arXiv1409.7395H", doi = "", isbn = "", issn = "", pmcid = "", pmid = "", callNumber = "", dimensions = "", scale = "", categories = [], language = "", citationNumber = CNum {unCNum = 0}, firstReferenceNoteNumber = 0, citationLabel = ""})
λ> resolveEitherDef "arXiv:1609.7395"
Left "Failed to connect: CurlHttpReturnedError"
λ> resolveEitherDef "ariv:1609.7395"
Left "Unknown identifier type: ariv"
```

Thank you, Adam!
