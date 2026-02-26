from duckduckgo_search import DDGS
import json

query = 'Install Champions'
print(f"Searching for: {query}")

try:
    with DDGS() as ddgs:
        results = list(ddgs.text(query, region='us-en', max_results=10))
        
        if not results:
            print("No results found.")
        else:
            for i, r in enumerate(results, 1):
                print(f"{i}. {r['title']}")
                print(f"   URL: {r['href']}")
                print(f"   Summary: {r['body'][:200]}...")
                print()
except Exception as e:
    print(f"An error occurred: {e}")
