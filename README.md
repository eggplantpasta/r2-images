# R2 Hosted Web Assets

This repo holds the scripts used to implement the workflow to optimise and upload images (mostly) to Cloudflare R2 for website use.

## Image optimisation and upload

```bash
source r2.env
scripts/process.sh
scripts/upload.sh
```

## Prerequisites

* [ImageMagick](https://imagemagick.org/)
  
Linux
```bash
sudo apt install awscli 
```

MacOS
```bash
brew install imagemagick
brew install ghostscript
```

* [AWS CLI](https://aws.amazon.com/cli/)

Linux
```bash
sudo apt install awscli 
```

MacOS
```bash
brew install awscli
```