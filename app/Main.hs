module Main where
import Network.HTTP.Conduit
import System.IO

main :: IO ()
main = do
    mapM_ (flip hSetBuffering LineBuffering) [stdin, stdout]
    man <- newManager tlsManagerSettings
    req <- parseUrl "https://s3.amazonaws.com/hackage.fpcomplete.com/package/lens-4.12.3.tar.gz"
    _response <- httpLbs req man
    pure ()