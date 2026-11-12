# /accept'i Claude Code'a kurma

🌐 [English](INSTALL.md) · **Türkçe**

`/accept`, Claude Code için bir skill. İsteğini anlamını değiştirmeden netleştirir, eksik bağlamı ekler ve uygular. Sadece `/accept` yazınca çalışır, kendiliğinden devreye girmez.

## Yol 1 — Kurulum script'i (önerilen)

Önce repoyu indir:

```bash
git clone https://github.com/Xyronb1/accept-skill.git
cd accept-skill
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

### macOS / Linux

```bash
bash scripts/install.sh
```

Daha önce kurulmuş bir `accept` varsa **silinmez**, `~/.claude/skills_backup/accept_<tarih>` klasörüne taşınır. Yedek `skills` klasörünün dışında tutulur ki Claude Code iki tane `/accept` görmesin.

### Sadece bir projeye kurma

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Target C:\proje\yolu\.claude\skills
```

```bash
bash scripts/install.sh /proje/yolu/.claude/skills
```

## Yol 2 — Elle kopyalama

`skill/accept` klasörünü olduğu gibi şuraya kopyala:

| Sistem | Kişisel (tüm projeler) | Tek proje |
|---|---|---|
| Windows | `%USERPROFILE%\.claude\skills\accept` | `<proje>\.claude\skills\accept` |
| macOS / Linux | `~/.claude/skills/accept` | `<proje>/.claude/skills/accept` |

`dist/accept-skill.zip` aynı `accept` klasörünü içerir; `skills` klasörüne çıkarman yeterli.

Kurduktan sonra Claude Code'u yeniden başlat.

## İlk ayar: context.md

Kurulan skill klasöründeki `context.md`'yi aç ve kendi bilgilerini yaz: işletim sistemin, kabuğun, diller ve sürümler, cevap dili, her işte geçerli tercihlerin, sık kullandığın projeler. Skill bunları hazır bilgi sayar ve tekrar sormaz. Boş bırakırsan skill bu adımı atlar. **Şifre, API anahtarı, token yazma.**

## Kullanım

| Komut | Ne yapar |
|---|---|
| `/accept <istek>` | İsteği netleştirir ve uygular |
| `/accept` | Bir önceki isteğini netleştirir |
| `/accept --prompt <istek>` | Sadece netleşmiş prompt'u verir (başka bir yapay zekaya/araca yapıştırmak için) |
| `/accept --sor <istek>` | Netleşmiş hali önce gösterir, onay verince uygular (İngilizcesi `--ask`) |
| `/accept --en <istek>` | Netleşmiş prompt'u İngilizce yazar |
| `/accept --tr <istek>` | Netleşmiş prompt'u Türkçe yazar |

Bayraklar birleşebilir: `/accept --prompt --en <istek>`. Türkçe yazarsan cevap ve özet de Türkçe gelir. Her çıktının sonunda kısa bir **"Ne değişti"** özeti olur.

## Kurulumu doğrulama

```powershell
powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1
powershell -ExecutionPolicy Bypass -File .\tests\validate.ps1 -SkillDir $HOME\.claude\skills\accept
```

macOS / Linux'ta aynı script PowerShell 7 ile çalışır: `pwsh tests/validate.ps1`.

Davranış testleri için [`tests/test-scenarios.md`](../tests/test-scenarios.md) içindeki istekleri tek tek dene.

## Kaldırma

`skills` klasöründeki `accept` klasörünü sil ve Claude Code'u yeniden başlat.
