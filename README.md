# Florin

English | [Nederlands](README.nl.md)

**Bookkeeping for Dutch freelancers (ZZP). Free, offline, and on your own computer.**

Florin keeps your invoices, expenses, BTW returns, hours, mileage, assets and pension allowance in one desktop app, and shows you what you will owe the Belastingdienst as you go. No subscription, no account, no cloud: your records are a single file on your own machine.

Available for macOS, Windows and Linux, in Dutch and English.

![Florin dashboard](docs/screenshots/dashboard.png)

[**Download the latest release**](../../releases/latest)

---

## Why Florin

- **Built for the Dutch ZZP rules.** Zelfstandigenaftrek, startersaftrek, MKB-winstvrijstelling, KIA, urencriterium and the BTW quarters are built in, not bolted on. Dutch tax terms have short explanations right in the app.
- **Know your numbers all year.** The dashboard shows revenue, costs, BTW to pay and an income tax estimate as you add invoices and expenses, so the annual return holds no surprises.
- **Your data stays yours.** Everything is stored in one local database file. You choose the folder, so you can keep it in a synced folder such as iCloud Drive, OneDrive or Dropbox for backup.
- **Ready for your accountant.** Export a full year to CSV files in one click: invoices, invoice lines, expenses, hours, mileage, assets and clients.
- **Free and open source** under the MIT license.

## Features

| | |
|---|---|
| **Invoicing** | PDF invoices in Dutch with automatic numbering. Credit notes, ICP (intracommunautaire prestaties) and BTW verlegd. Status tracking from draft to paid, including overdue. |
| **Expenses** | Costs by category with BTW reclaim, business use percentage for mixed costs, and receipt tracking. |
| **BTW-aangifte** | Quarterly return pre-filled from your invoices and expenses: rubrieken 1a, 1b, 1c, 3a, 5a and 5b. Track filing and payment per quarter, with the filing deadline shown for each. |
| **P&L and tax estimate** | Income tax estimate with zelfstandigenaftrek, startersaftrek, MKB-winstvrijstelling, KIA / EIA / MIA, depreciation, lijfrente, algemene heffingskorting and arbeidskorting. |
| **Urencriterium** | Hours per client and project, with progress towards the 1,225 hours a year you need for the zelfstandigenaftrek. |
| **Mileage** | Business trips with odometer readings and purpose, and the deductible allowance at €0.23/km. |
| **Fixed assets** | Straight-line depreciation, business use percentage and KIA / EIA / MIA eligibility, fed straight into your tax estimate. |
| **Pension (jaarruimte)** | Your annual pension allowance with AOW franchise, factor A and unused room from earlier years. |
| **Clients** | Contact details, BTW and KVK numbers, and Wet DBA risk level per client. |

## Install

Download the file for your system from the [latest release](../../releases/latest).

### macOS

With [Homebrew](https://brew.sh):

```sh
brew tap rashadansari/florin https://github.com/RashadAnsari/florin
brew install --cask florin
```

Or manually:

1. Unzip `florin-macos.zip`
2. Move `Florin.app` to your Applications folder
3. Open `Florin.app`

Florin is signed and notarized by Apple. Requires macOS 10.15 or later.

### Windows

1. Download and run `florin-windows-x64-setup.exe`
2. If Windows SmartScreen appears, click **More info**, then **Run anyway**
3. Follow the installer. Florin is added to the Start menu and can be removed from **Settings > Apps** like any other app.

For a portable version without installing, unzip `florin-windows-x64.zip` and run `florin.exe`.

### Linux

On Ubuntu, Debian, Linux Mint and other Debian-based systems, download `florin-linux-amd64.deb` and open it to install. Florin then appears in your app menu.

On other distributions, extract `florin-linux-x64.tar.gz` to a folder and run `./florin`.

## FAQ

**Where is my data stored?**
In a single file, `florin.db`. You pick its folder when you first start Florin and can move it later in Settings.

**How do I back up my data?**
Keep the database folder inside a synced or backed-up folder, or copy `florin.db` somewhere safe. Close Florin before copying it.

**Can Florin file my BTW return or income tax return?**
No. Florin prepares the figures; you file them yourself in Mijn Belastingdienst Zakelijk, or your accountant does.

**Does Florin need an internet connection?**
No. Florin never uploads your data. When you are online it downloads its fonts from Google Fonts; offline it falls back to standard fonts and keeps working.

## Build from source

Florin is a Flutter app. Install the Flutter version listed under `environment.flutter` in `pubspec.yaml`, then run:

```sh
git clone https://github.com/RashadAnsari/florin.git
cd florin
flutter pub get
flutter run -d macos   # or windows / linux
```

Before committing, run `make local` to generate translations, format the code and run the analyzer.

### Releasing

Raise `version` in `pubspec.yaml` (for example `1.2.0+3`) and push it to `master`. The release workflow builds macOS, Windows and Linux, tags the commit as `1.2.0-3` and publishes the GitHub release. It does nothing if a release for that version already exists.

## Disclaimer

Florin helps you organise your financial records. It is not a substitute for professional tax or legal advice.

The tax calculations, deductions and figures in Florin are estimates based on publicly available Dutch tax rules. They may be incomplete, outdated or not applicable to your situation. Always check your tax obligations with a qualified accountant (boekhouder) or tax advisor before filing with the Belastingdienst.

The author accepts no liability for errors in calculations, missed deadlines, incorrect filings, financial loss or any other consequence of using this software. Use Florin at your own risk.

## License

[MIT](LICENSE)
