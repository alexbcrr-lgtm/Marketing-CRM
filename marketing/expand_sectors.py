from duckduckgo_search import DDGS
import json
import time

queries = [
    'healthcare furniture dealers Southern California',
    'education furniture dealers Los Angeles Orange County',
    'hospitality furniture dealers San Diego',
    'government furniture contractors Southern California',
    'Teknion dealers Southern California',
    'Allsteel dealers Los Angeles',
    'Global Furniture Group dealers SoCal',
    'National Office Furniture dealers San Diego',
    'AIS furniture dealers Southern California'
]

new_leads = []

print("🚀 AGGRESSIVE EXPANSION: Targeting Specialized Sectors (Healthcare, Ed, Gov)...")

with DDGS() as ddgs:
    for query in queries:
        print(f"Searching: {query}")
        try:
            results = list(ddgs.text(query, region='us-en', max_results=15))
            for r in results:
                new_leads.append({
                    "title": r['title'],
                    "href": r['href'],
                    "body": r['body']
                })
            time.sleep(1) 
        except Exception as e:
            print(f"Error searching {query}: {e}")

with open('marketing/sector_leads_raw.json', 'w') as f:
    json.dump(new_leads, f, indent=2)

print(f"✅ Found {len(new_leads)} potential specialized sector leads.")
