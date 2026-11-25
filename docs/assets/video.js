// Turn ![alt](clip.mp4) images into playable videos.
// The Markdown stays image syntax so md2canoprof can import it into Canoprof.
document$.subscribe(function ()
{
    document.querySelectorAll("article img").forEach(function (img)
    {
        const src = img.getAttribute("src") || "";
        if (!/\.(mp4|webm)$/i.test(src))
        {
            return;
        }
        const video = document.createElement("video");
        video.src = src;
        video.controls = true;
        video.preload = "metadata";
        video.title = img.alt;
        video.style.maxWidth = "100%";
        img.replaceWith(video);
    });
});
