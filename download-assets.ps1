$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$assetRoot = Join-Path $projectRoot 'assets'

function Get-RemoteFile {
    param(
        [Parameter(Mandatory)] [string] $Url,
        [Parameter(Mandatory)] [string] $RelativePath
    )

    $target = Join-Path $assetRoot $RelativePath
    $directory = Split-Path -Parent $target
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
    Write-Host "Downloading $RelativePath"
    & curl.exe -L --fail --silent --show-error --retry 3 --output $target $Url
    if ($LASTEXITCODE -ne 0) { throw "Download failed: $RelativePath" }
}

$files = @(
    @{ Path = 'sunshine/brief/content-brief.pdf'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096691446/f21631ba1b4564f874f1aa94cd47ba2b/____52_________pdf____.pdf?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio_A-fM0z0aHsKYPkkfak1UhFBxDVdLUBZ_Rz990AV4qrHLwxGyQPxKx71N4-bAmmXloDzA7laZ3RxD3Byewyl_5VWR46Qj6JZppnS7WP-EJ_kxUQNUxnpRcD6q70j-oBbqTuhDoRFLT7reJkDYIAt9g=' },
    @{ Path = 'animals/brief/content-brief.pdf'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096690718/20760bdd8e75e7cd08c8f062b8d42012/_______________.pdf?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio8s-qtyZbwBquKmcAL8bqR6zFCkhhQQe21Gzym0cMKuaZbQITKQka2bUbjrKXgHRCJxda4VH44BoVP9CarjOE9-zs-ihGG8nyCizeHipZO0ENhrNcUHCAQUxvhSVM8wOldzxv8UkhSEdkiKVxCj8TKU=' },
    @{ Path = 'e1i5/brief/content-brief.pdf'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6090941769/6dd10b3d58487dfb6a1d9243baccbf04/____________________.pdf?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio3SNKhLN1pdf-nizzIKt0gMWxSVGn5yxgeYiQ-EpKaN6aPs-ixSxB6vjT0xNNOB4-pKjtD2LOcISJdH8S71eWhvbl_w64pG2E2lBU7E5hltLhg-KOJBQqVRHWyHsRthQ_P48ts85LQeAE0qiieqkfLo=' },
    @{ Path = 'chicchoc/brief/content-brief.docx'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096780031/b8b73bcc2a457696d848809069c5fad8/Personal_Dessert_Guide____________.docx?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio8sA5wRzFTMIryDZ15_dQMRRyiEVVJb0aEglkqmPEa6OOIpXVxuMdfUKPh25GZpGIS0Bq6k_MfrDVCYWvhfRl7AMHlbaiaW6Cu0SDr96ynYg5dyUJKwqsRc8I9OzNPV4icspUgYodcFkR-xr5BQOeHS9B2CCGX_FtEPyqysuu1vJ' },

    @{ Path = 'animals/posters/01.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096690718/8eb0fc562fa2f562dde58983c1d1fd99/Gemini_Generated_Image_i9dl9gi9dl9gi9dl.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio8s-qtyZbwBquKmcAL8bqR7O7_tn68RIyIHoF0XmS_kPR2hlpYCpArnCafgwNhgWyP_kpujzekUFquPrrALJNM4nU2PpUEnf29PGUV0TwmqSPTksiQanobjwyRF2l3jaau4FVvwlJdrG2RHA9191wcVe9yg8D9EVo_JOLf_zbMO4' },
    @{ Path = 'animals/posters/02.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6090961857/d97428c5b334a13ff1f7d6554d0751e4/image.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio1Z5W-VylEA5A5rurZW6mIL5gWD9lj2-KodLAlG9puHVBMStEI7r3e-BEaHQ21L7kHc4zL-rEEZIT3L7yqKF3ebSHhzYF_5-2HdbeshGGeoRz-CVYf54AyeRGB4l496UCw==' },
    @{ Path = 'animals/posters/03-a.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6091113489/84fd7e43b0eef9ed3c696d2c3c5f3b1b/___2___.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKiowRuviI_gHTQ3VpZ0QKsLxiWGeiWOFQcV3pJJU0KAlSHfhHKEp_YHDzokiv2Z2YQvdSfYVsfIjq0NDLNj63tUmwPQmkMylOozSjqxb62vErV1GrTd5g-tMnriqwA1tUoFA==' },
    @{ Path = 'animals/posters/03-b.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6091113489/0da377412f0c6c8ca2a73796d2c265ad/______.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKiowRuviI_gHTQ3VpZ0QKsLxgPRBIn_vh_71Ctw8P14eRGNhBEQWxwN9EfGouxXE9ERFhmWbu7qpxorKqdN71mWmBY1gu2Ef2RS3T528Xv1nmWfMRuiBRhw4hGlA7OgnTxwQ==' },
    @{ Path = 'animals/posters/04.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096697570/95a6f1367a7ff0036313d58689675071/Gemini_Generated_Image_35d4735d4735d473.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio5GrZJ8i5S_wBMRmkpSkagRZeyy-bje0Zq2ACrJ3OHDpRf_RCz-WqCtXDFch4iUb5hf7-f8Sqg6U6k-CKeb49Ekb2C_2Xh1RgefPoECIsxXLjEZH2DYjlww630a3BsasUYKsbG8xQ3MP_kbmfvRiaWe4o8UqAV-WNrAbbfaAraza' },
    @{ Path = 'animals/posters/05.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096691869/671e0ca9e3a634a8cd44b9f2bb7531e9/image.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio7cMgy79Zfc6xiVvxdfNtG8NNcrCVSNo4eqM8JH4D7vgJVFsGbo02JhwKDbYsvQiXkKLQH4JkDrcaUMyCSo-zCiQ6o0HsS20d6YNYnKtXRpqjU1IC-udJq_Ld-GoKWnkeQ==' },
    @{ Path = 'sunshine/posters/01.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096691084/741052045537018f1a8fe9873e2d900c/____.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio-M1A0yjIwNYMvUGGYADCRMOZbr-_96Kc7lhrPl_ASFmxhUS0Gqpci5dvJnXkVYckQIZWXYkK3r-epDLGag9iIaGDe4LPkN1-i_rO_NvoAnDthMGFFn99m6FpvEPPMiHwA==' },
    @{ Path = 'sunshine/posters/02.jpg'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6097497466/288bf75f1c98287c8334e6ffb6cad17d/______.jpg?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio48tLn_hz9i6q-38IkXH1xv4VnLPxDQwxJo1a1YXD42ma-dZmu8_PDdwCmaWtOUsPC2O5ysrx52xOxwK6FOJtJHUoS1oYyopSNCITKQ9HNIAbCSsfFKH5dgBq8GGOxJvQA==' },

    @{ Path = 'animals/cardnews/01.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096690718/a8156d24748f98a4f925738bdddb0128/Gemini_Generated_Image_g40m1ng40m1ng40m.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio8s-qtyZbwBquKmcAL8bqR6qebLPxV7Ly8bxyb7PunHk7lziTs1Zs_C95YztaBKU5pRAQsvfNO6fmawJAaMw_l1zPxAzb9xcYir-w2vfvQf6xOprtxCWeNRPBswoJGaCSvaYtKgRxQJ_R9k94eDZnxI9lSNgbn4n-Pu6hsMZd0eg' },
    @{ Path = 'animals/cardnews/02.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096697570/b0adbdc9ffc36e173de0f23ae02617fc/Gemini_Generated_Image_rpeb7wrpeb7wrpeb.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio5GrZJ8i5S_wBMRmkpSkagRLXXIRkHzJp9WFhlmjRr3tOdpiZJq9-7aP2mKnwXajKe5taIMsUmbXMCO1oCo1Ng2yHyIvMIxHm5dmRT8H5lzR6h35FifFSnS7GrgYah5oOwEM9IcPVt662NoOeYXH4-Skd1O1BkAqbGJLPxYWjLZP' },
    @{ Path = 'animals/cardnews/03.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6091113489/36c8ef7f492667a45dc0739f8cbcf4d9/____3.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKiowRuviI_gHTQ3VpZ0QKsLxgIm5DLr1FikdsAEGcGiH5ra4UG_kJNQpltKhnDwboUGTLfndbVjaze0REbEPWVaNALQaGXc1mvQWTbSU7Sqpnz-qMDhZE877wbkerxmLer7A==' },
    @{ Path = 'animals/cardnews/04.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6090961857/e31d0750ae7b87b333a73bd332030942/image.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio1Z5W-VylEA5A5rurZW6mILcVWed58xSR6W3rqvCrA4YZfaqojvtjBPAnLKbWi6RnBDq5AKlKPbKz2E3HbdGgoDwDD-SODlnvv8Ko-R9vIG3b4eyRmMBqRSOK_4JplDVaA==' },
    @{ Path = 'animals/cardnews/05.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096691869/917aa2aecd8c73eb3bcff6b6f8099eb9/image.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio7cMgy79Zfc6xiVvxdfNtG9VyxDlAKtgfZos1-YL1LoLsrF5btSKOLaqa5r3MHUysOeloaua85EUgiFzsgNIA1FRA046X_rC1TeIESlSSs2FmDPjUCjQPec0Vs-exZKwYg==' },
    @{ Path = 'sunshine/cardnews/01.jpg'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096691446/efa25cb3de24159c49cf5a973f73d8b2/0e0d6909_4acd_4069_87f0_798f6fa4c362.jpg?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio_A-fM0z0aHsKYPkkfak1UgU0ciwau8hM9oTNWdPzfAMxPEDiurFn3P-vb2mV-WXjUmCgnTT649jIBLa_EQ7kM0k_2mnqujXIp32WnLDWiaJoDAw2AqLxdYtLRPSScIgJnZVJ6l1SLv-rqhY6Y7XiS8ODLBDWZ1La-jiiCgOu4Cb' },
    @{ Path = 'e1i5/cardnews/01.png'; Url = 'https://u1.padletusercontent.com/uploads/padlet-uploads-usc1/6096690604/24f1b525a51d7973b3321e0814be3c1d/____1.png?expiry_token=5WaHZRdGG3LkUVQGy3SZ-zdRtq89aJeottSBaF_Hii8dmxJqYDvE2-MDbblcM-ZrVekXW99RReKkJFIoMoKio0-HBDMHHQ4rCBeF626XLTRdHwPcONg7wQKRt9ODSrDmzWwTVPFavw2lpLjsztO4p9OqPP9IPK_K1fi-o6diasbbl_mBgTjr558wgPDZc0QKHW-Gdw5RWfEHPCKjOP_8cw==' }
)

foreach ($file in $files) {
    Get-RemoteFile -Url $file.Url -RelativePath $file.Path
}

$videoIds = @(
    @{ Path = 'e1i5/shorts/01.mp4'; Id = '5e552aca0c67143ed1266381761a0304' },
    @{ Path = 'animals/shorts/01.mp4'; Id = 'a2ad2c85d7ab0d0570f62d71f8154e58' },
    @{ Path = 'chicchoc/shorts/01.mp4'; Id = 'a0bdedaecc20b098e9fa6236f07d8622' }
)

$toolRoot = Join-Path $env:TEMP 'k-ai-imageio-ffmpeg'
$wheelRoot = Join-Path $toolRoot 'wheel'
$ffmpeg = Get-ChildItem -Path $wheelRoot -Filter 'ffmpeg*.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $ffmpeg) {
    New-Item -ItemType Directory -Force -Path $toolRoot, $wheelRoot | Out-Null
    & py -m pip download --disable-pip-version-check --no-deps --dest $toolRoot imageio-ffmpeg
    if ($LASTEXITCODE -ne 0) { throw 'Unable to download the temporary FFmpeg package.' }
    $wheel = Get-ChildItem -Path $toolRoot -Filter '*.whl' | Select-Object -First 1
    $zipPath = Join-Path $toolRoot 'imageio-ffmpeg.zip'
    Copy-Item -LiteralPath $wheel.FullName -Destination $zipPath -Force
    Expand-Archive -LiteralPath $zipPath -DestinationPath $wheelRoot -Force
    $ffmpeg = Get-ChildItem -Path $wheelRoot -Filter 'ffmpeg*.exe' -Recurse | Select-Object -First 1
}

foreach ($video in $videoIds) {
    $target = Join-Path $assetRoot $video.Path
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    $manifest = "https://videodelivery.net/$($video.Id)/manifest/video.m3u8"
    Write-Host "Downloading $($video.Path)"
    & $ffmpeg.FullName -hide_banner -loglevel error -y -i $manifest -c copy -movflags +faststart $target
    if ($LASTEXITCODE -ne 0) { throw "Video download failed: $($video.Path)" }
}

Write-Host 'All Padlet assets downloaded.'
