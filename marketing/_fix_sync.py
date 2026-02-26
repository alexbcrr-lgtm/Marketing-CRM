with open('sync_dashboard.py', encoding='utf-8') as f:
    content = f.read()

# The actual bytes on line 209 have: \\'  (two chars: backslash then single-quote)
old = "f'Last synced: {datetime.now().strftime(\\'%Y-%m-%d %H:%M:%S\\')} PST'"
new = 'f"Last synced: {datetime.now().strftime(\'%Y-%m-%d %H:%M:%S\')} PST"'

if old in content:
    content = content.replace(old, new)
    with open('sync_dashboard.py', 'w', encoding='utf-8') as f:
        f.write(content)
    print("FIXED")
else:
    print("Still not found")
    lines = content.split('\n')
    # Print raw bytes
    line = lines[208]
    print(f"Bytes: {line.encode('utf-8')}")
