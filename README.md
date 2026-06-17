# ClassTrack

A single-file classroom score tracker backed by Supabase.

## Setup (3 steps)

### 1. Create `config.js`

Copy the example and fill in your Supabase project details:

```bash
cp config.example.js config.js
```

Edit `config.js`:

```js
window.ENV = {
  SUPABASE_URL:  'https://YOUR-PROJECT-REF.supabase.co',
  SUPABASE_ANON: 'YOUR-SUPABASE-ANON-KEY',
};
```

> `config.js` is listed in `.gitignore` — it will **never** be committed to GitHub.

### 2. Run the SQL in Supabase

Open your Supabase project → **SQL Editor** → paste and run `supabase_setup.sql`.

This creates the `admins` table and seeds your first admin account.
**Change the password in the SQL file before running it.**

### 3. Open `classroom_tracker.html` in a browser

No build step needed. Works locally or hosted on GitHub Pages / Netlify / any static host.

---

## What's in each file

| File | Purpose | Commit? |
|------|---------|---------|
| `classroom_tracker.html` | The whole app | ✅ Yes |
| `config.example.js` | Template for secrets | ✅ Yes |
| `config.js` | Your actual secrets | ❌ No (gitignored) |
| `supabase_setup.sql` | DB schema + seed | ✅ Yes |
| `.gitignore` | Keeps config.js out of git | ✅ Yes |

---

## Changing the admin password

Go to **Supabase Dashboard → Table Editor → admins** and edit the row directly.
Never change it in the HTML — that's the whole point.

## Adding more admins

Insert additional rows into the `admins` table via the Supabase dashboard or SQL:

```sql
insert into admins (username, password) values ('teacher2', 'their_password');
```
