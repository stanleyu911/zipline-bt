docker run --rm -p:8888:8888/tcp --name zipline -v /Volumes/media/GitHub/zipline-bt/backtest:/projects -v /Volumes/media/GitHub/zipline-bt/.zipline:/root/.zipline -v /Volumes/media/GitHub/zipline-bt/backtest/Clenow/data:/root/.zipline/Clenow/data -it stanleyu/quantopian-zipline

