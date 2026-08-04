# Vercel Deployment Guide — Vanity Cheats

This folder contains everything you need to host your script on Vercel.

---

## Step 1: Create a GitHub Repo

1. Go to https://github.com/new
2. Name it `vanitycheats` (or whatever you want)
3. Make it **Public**
4. Click **Create repository**

---

## Step 2: Upload These Files

Upload **all** the files in this `vercel-deploy/` folder to your GitHub repo root.

Your repo should look like this:

```
vanitycheats/
├── index.html
├── vercel.json
└── scripts/
    └── VanityGeneral.lua
```

**Quick way:** Drag and drop the files directly into the GitHub web UI after creating the repo.

---

## Step 3: Connect to Vercel

1. Go to https://vercel.com/new
2. Sign in with your **GitHub** account
3. Find and select your `vanitycheats` repo
4. Click **Import**
5. On the project settings page:
   - **Project Name:** `vanitycheats`
   - **Framework Preset:** `Other` (just leave it as default)
6. Click **Deploy**

Wait ~30 seconds. Vercel will give you a URL like:
```
https://vanitycheats.vercel.app
```

---

## Step 4: Add Your Custom Domain (vanitycheats.com)

1. In your Vercel dashboard, go to your project → **Settings** → **Domains**
2. Type `vanitycheats.com` and click **Add**
3. Vercel will show you DNS records. Go to your domain registrar (where you bought `vanitycheats.com`) and add these:

| Type | Name | Value |
|------|------|-------|
| A | @ | 76.76.21.21 |
| CNAME | www | cname.vercel-dns.com |

4. Wait 5–30 minutes for DNS to propagate
5. Your site will now be live at `https://vanitycheats.com`

---

## Step 5: Your Final Loadstring

Once deployed, your users paste this into any Roblox executor:

```lua
loadstring(game:HttpGet("https://vanitycheats.com/scripts/VanityGeneral.lua"))().Start()
```

---

## Updating the Script Later

When you make changes:

1. Re-run the build tools in your local project:
   ```
   python tools/build.py
   .venv-obf/Scripts/python.exe tools/obfuscate.py dist/VanityGeneral_INTEGRATED.lua dist/VanityGeneral_OBF.lua
   python tools/encrypt.py dist/VanityGeneral_OBF.lua release/VanityGeneral.lua
   ```

2. Copy the new `release/VanityGeneral.lua` into this folder (overwriting the old one)

3. Commit and push to GitHub:
   ```
   git add .
   git commit -m "update script"
   git push
   ```

4. Vercel will **auto-deploy** the update in ~30 seconds

---

## What `vercel.json` Does

It tells Vercel to serve the `.lua` file with these headers:
- `Access-Control-Allow-Origin: *` — Required for Roblox's `HttpGet` to fetch it
- `Content-Type: text/plain` — Served as plain text (not downloaded)
- `Cache-Control: no-cache` — Ensures users always get the latest version
