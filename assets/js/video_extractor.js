(function () {
    const videos = document.querySelectorAll('video') //TODO: video 찾는 부분, 나중에 수정해야함.
    const videoInfoList = [];

    videos.forEach(video => {
        const src = video.currentSrc || video.src;
        const title = document.title || 'No Title';
        const thumbnail = video.poster || '';

        if (src) {
            videoInfoList.push({
                url: src,
                title: title,
                thumbnail: thumbnail
            });
        }
    });

    return JSON.stringify(videoInfoList);
})();