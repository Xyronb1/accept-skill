# /accept'i ChatGPT ve Claude sohbetinde kullanma

🌐 [English](CHAT-APPS.md) · **Türkçe**

`/accept` iki şekilde çalışır:

- **Claude Code** (terminal / masaüstü Code sekmesi): skill olarak kurulur, bkz. [INSTALL.tr.md](INSTALL.tr.md). Orada `/accept` gerçek bir komuttur.
- **ChatGPT ve Claude (normal sohbet / web / uygulama):** evrensel prompt metnini modele bir kez tanıtırsın; sonra her sohbette `/accept <istek>` veya `accept: <istek>` yazarsın.

| Dosya | Dil |
|---|---|
| [`prompts/universal-prompt.md`](../prompts/universal-prompt.md) | İngilizce |
| [`prompts/universal-prompt.tr.md`](../prompts/universal-prompt.tr.md) | Türkçe |

İki sürüm de senin yazdığın dile uyar; düzenlemesi sana kolay geleni seç. Aşağıdaki yöntemler hesabına bağlıdır; bir kez kurunca **farklı cihazlarda ve yeni sohbetlerde** çalışır.

## ChatGPT

Evrensel prompt'un tamamını kopyala, sonra şunlardan birine yapıştır:

1. **Custom GPT (en kalıcı, önerilen):** bir GPT oluştur ve metni **Instructions** alanına yapıştır. O GPT'yi her cihazda açarsın.
2. **Project:** bir Project aç ve metni project instructions alanına yapıştır. O projedeki tüm sohbetlerde geçerli olur.
3. **Custom Instructions:** kişiselleştirme ayarlarında. Yer sınırlı olabilir; sığmazsa Custom GPT veya Project kullan.

Kullanım: `/accept bir klasördeki pdf'leri birleştir` ya da `accept: --sor eski logları sil`.

> Menü adları zamanla değişebilir; alanı bulamazsan GPT/Project ayarlarında "instructions" kısmına bak.

## Claude

- **Claude Code:** [INSTALL.tr.md](INSTALL.tr.md)'yi izle. `/accept` komut olarak çalışır.
- **Claude.ai / Claude uygulaması (sohbet):** bir **Project** oluştur ve evrensel prompt'u project instructions alanına yapıştır. O projedeki her sohbette `/accept` çalışır. Tek seferlik denemek için metni sohbetin başına bir kez yapıştırman da yeter.

## Kalıcı bağlamı taşımak

- Claude Code'da bağlam skill'in `context.md` dosyasındadır (her bilgisayara ayrı yazarsın).
- ChatGPT/Claude sohbetinde bağlam, evrensel prompt'un en altındaki **KALICI BAĞLAM** bölümüne yazdığın satırlardır. Bir kez doldurursan yapıştırdığın her yerde seninle gelir.
- Oraya şifre, API anahtarı veya token yazma.

## Platforma göre özet

| Nerede | Bir kez yap | Sonuç |
|---|---|---|
| ChatGPT | Custom GPT / Project / Custom Instructions'a yapıştır | Tüm cihazlarda ve yeni sohbetlerde çalışır |
| Claude.ai / uygulama | Project instructions'a yapıştır | O projedeki tüm sohbetlerde çalışır |
| Claude Code | Her bilgisayara `install.ps1` / `install.sh` ile kur | O bilgisayardaki tüm oturumlarda çalışır |
