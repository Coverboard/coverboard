# CoverBoard

## The COVERBOARD!
Display of nightly builds with code coverage. This metrics are going to be historic and displayed on a fancy way on a screen.
Must run on our shitty raspberry py!

![Logo](http://orig12.deviantart.net/8830/f/2012/355/5/e/16_bit_hoverboard_w__santa_hat_by_joegpcom-d5oqjbp.gif)

## Rules
- No PHP!
`End of rules`

## Coverage
Run in this order:

- `gem install bundler`
- `bundle install`

## Sending metrics
Example metrics
- Total coverage: 13.0%
- Models coverage: .5%

Request POST /api/metrics
payload:
```
{
    uid: 'qwerty123456',
    ts: 123423,
    metrics: {
        'coverage': 1300,
        'coverage-models': 50,
        'coverage-*': x 
    }
}
```

## Team members
- Yair
- Michal
- Lautaro

![Hacking!](http://forums.windowscentral.com/attachments/microsoft-news-rumors/103808d1430749991t-bloody-keyboard-wreck-o.jpg)

## End of the hackaton
![End](http://media.tumblr.com/719fff5313f0a18a4836be13334b1b8a/tumblr_inline_nglo2t4jUD1raprkq.gif)

