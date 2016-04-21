{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Monad
import Network.Socket hiding (send, recv)
import Network.Socket.ByteString.Lazy
import Network.HTTP.Conduit
import Network.HTTP.Client (defaultManagerSettings)
import qualified Data.ByteString.Lazy.Char8 as LC8
import System.Environment (getArgs)


import Network.Wai (responseLBS, Application)
import Network.Wai.Handler.Warp (run)
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)

-- crashes/hangs
main :: IO ()
main = do
    man <- newManager tlsManagerSettings
    req <- parseUrl "https://s3.amazonaws.com/hackage.fpcomplete.com/package/lens-4.12.3.tar.gz"
--    man <- newManager defaultManagerSettings
--    req <- parseUrl "http://ipv4.download.thinkbroadband.com/200MB.zip"
    response <- httpLbs req man
    LC8.putStrLn $ responseBody response
{-

{-main :: IO ()
main = do
    [arg] <- getArgs
    case arg of
        "listen" -> do
            sock <- socket AF_INET Stream defaultProtocol
            hostAddr <- inet_addr "127.0.0.1"
            bind sock $ SockAddrInet 2000 hostAddr
            listen sock 1
            (sock' , _) <- accept sock
            forever $ do
                send sock' $ LC8.replicate 4096 'h'
                recv sock' 4096
                close sock'
        "connect" -> do
            sock <- socket AF_INET Stream defaultProtocol
            hostAddr <- inet_addr "127.0.0.1"
            connect sock $ SockAddrInet 2000 hostAddr
            forever $ do
                send sock $ LC8.replicate 4096 'h'
                recv sock 4096
-}

main = do
    [arg] <- getArgs
    case arg of
        "server" -> run 2000 app
        "client" -> do
            man <- newManager defaultManagerSettings
            req <- parseUrl "http://192.168.10.121:2000"
            response <- httpLbs req man
            pure ()

app :: Application
app req f =
    f $ responseLBS status200 [(hContentType, "text/plain")] $ LC8.replicate (20*1024*1024*1024) 'h'
    
    -}