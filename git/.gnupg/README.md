# README

## Creating Keys

I just used Git Tower to create the key.

It should work like this:

```
gpg --full-generate-key
```

## Saving Keys

Get the Key ID. (e.g. `12345678`)
```
# Or from Tower
gpg --list-secret-keys --keyid-format=long
```

```
gpg --armor --export 12345678 | pbcopy
```

Then paste the clipboard on github.com

## Links
- https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
