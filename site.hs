#!/usr/bin/env runhaskell
--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid
import qualified Data.Text as T
import qualified Data.Text.IO as T
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.rst", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*.md" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= linkThumbnail
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*.md"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*.md"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext


linkThumbnail :: Item String -> Compiler (Item String)
linkThumbnail item = do
  fnDir <- getResourceFilePath
  let
    inner :: T.Text -> T.Text
    inner =  T.unlines . map convertJPG . T.lines
    
    fnTxt :: T.Text
    fnTxt = T.replace "./posts/" "/images/" $ 
            T.replace ".md//" "" $ 
            (T.pack fnDir <> "//") 
      
    
    convertJPG :: T.Text -> T.Text
    convertJPG lin 
      | not (T.isSuffixOf ".JPG</p>" lin) = lin
      | otherwise = 
          T.replace "FNDIR" fnTxt $
          T.replace "FNBODY" (fnBodyOf lin) tmpl          

    fnBodyOf lin = 
      T.replace "<p>" "" $ T.replace ".JPG</p>" ""  lin
  
    tmpl :: T.Text
    tmpl = "<center><a  href=\"FNDIR/FNBODY.JPG\" target=\"_blank\"><img src=\"FNDIR/FNBODY-th.png\" style=\"float: center; margin: 10px;\" /></a></center>\n"

  
  return $ fmap (T.unpack . inner . T.pack) item