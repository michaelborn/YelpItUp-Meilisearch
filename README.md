# YelpItUp

A sample Meilisearch app using the [Yelp dataset](https://www.yelp.com/dataset/), [Coldbox](https://www.coldbox.org/), and [cbMeilisearch](https://github.com/michaelborn/cbmeilisearch).

![YelpItUp app showing sample Yelp reviews for "pickle"](includes/images/yelp-it-up-pickle-search.png)

## Getting Started

1. Clone this repo - `git clone git@github.com:michaelborn/YelpItUp.git`
2. [Install CommandBox if you don't have it](https://commandbox.ortusbooks.com/getting-started-guide)
3. Download the [Yelp dataset](https://www.yelp.com/dataset) and extract to `resources/downloads/yelp_dataset`
4. Install dependencies - `box install`
5. Start up a docker Meilisearch container - `docker run --detach --rm -p 7700:7700 -e MEILI_MASTER_KEY='ortus_is_awesome' -v $(pwd)/meili_data:/meili_data getmeili/meilisearch meilisearch --env="development"`
6. Copy `.env.example` to `.env`
7. Start this app - `box start`

## The Good News

> For all have sinned, and come short of the glory of God ([Romans 3:23](https://www.kingjamesbibleonline.org/Romans-3-23/))

> But God commendeth his love toward us, in that, while we were yet sinners, Christ died for us. ([Romans 5:8](https://www.kingjamesbibleonline.org/Romans-5-8))

> That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved. ([Romans 10:9](https://www.kingjamesbibleonline.org/Romans-10-9/))
 
## Repository

Copyright 2020 (and on) - [Michael Born](https://michaelborn.me/)

* [Homepage](https://github.com/michaelborn/YelpItUp-Meilisearch/)
* [Issue Tracker](https://github.com/michaelborn/YelpItUp-Meilisearch/issues)
* [New BSD License](https://github.com/michaelborn/YelpItUp-Meilisearch/src/master/LICENSE.txt)

[![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/made-with-cfml.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/tested-with-testbox.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/powered-by-coffee.svg)](https://cfmlbadges.monkehworks.com) [![cfmlbadges](https://cfmlbadges.monkehworks.com/images/badges/i-can-bench-press-ben-nadel.svg)](https://cfmlbadges.monkehworks.com)