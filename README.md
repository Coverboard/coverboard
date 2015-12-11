# CoverBoard


## The game of code
Automation of nightly builds with code coverage. This metrics are going to be historic and displayed on a fancy way on a screen.
Must run on our shitty raspberry py!

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
