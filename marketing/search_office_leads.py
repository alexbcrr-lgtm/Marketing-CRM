from duckduckgo_search import DDGS
import json
import time

queries = [
    'commercial office furniture dealers Los Angeles',
    'Steelcase dealers Southern California',
    'MillerKnoll showrooms Los Angeles Orange County',
    'Haworth furniture dealers San Diego',
    'contract furniture dealers Southern California',
    'corporate office furniture showrooms Irvine',
    'high-end office furniture dealers West Hollywood'
]

new_leads = []

print("🚀 Searching for Office Furniture Dealers...")

with DDGS() as ddgs:
    for query in queries:
        print(f"Searching: {query}")
        try:
            results = list(ddgs.text(query, region='us-en', max_results=10))
            for r in results:
                new_leads.append({
                    "title": r['title'],
                    "href": r['href'],
                    "body": r['body']
                })
            time.sleep(1) 
        except Exception as e:
            print(f"Error searching {query}: {e}")

with open('marketing/office_leads_raw.json', 'w') as f:
    json.dump(new_leads, f, indent=2)

print(f"✅ Found {len(new_leads)} potential office furniture leads.")
