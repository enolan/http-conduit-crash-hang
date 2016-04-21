module Main where
import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy.Char8 as LC8

main :: IO ()
main = do
    man <- newManager tlsManagerSettings
    req <- parseUrl "https://s3.amazonaws.com/hackage.fpcomplete.com/package/lens-4.12.3.tar.gz"
    response <- httpLbs req man
    LC8.putStrLn $ responseBody response
