#!/usr/bin/env python3
"""
IC_LOGISTICS Dashboard Sync
Updates the browser-based Command Center with latest intel
"""
import json
from datetime import datetime

def load_json(path):
    try:
        with open(path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return {}

def generate_html(targets, intel, state):
    """Generate the Command Center HTML dashboard"""
    
    tier1_count = len(targets.get('priority_tiers', {}).get('tier_1', []))
    tier2_count = len(targets.get('priority_tiers', {}).get('tier_2', []))
    tier3_count = len(targets.get('priority_tiers', {}).get('tier_3', []))
    total_contacts = intel.get('total_contacts', 0)
    
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IC_LOGISTICS Command Center</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #0f0f0f;
            color: #fff;
            padding: 20px;
        }}
        .header {{ 
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 4px solid #00d4ff;
        }}
        .header h1 {{ font-size: 28px; margin-bottom: 8px; }}
        .header p {{ color: #888; }}
        .grid {{ display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 30px; }}
        .card {{
            background: #1a1a1a;
            border-radius: 12px;
            padding: 24px;
            border: 1px solid #333;
        }}
        .card h3 {{ color: #00d4ff; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }}
        .metric {{ font-size: 48px; font-weight: 700; margin-bottom: 8px; }}
        .metric.small {{ font-size: 36px; }}
        .label {{ color: #888; font-size: 14px; }}
        .tier-bar {{ display: flex; gap: 8px; margin-top: 16px; }}
        .tier {{ flex: 1; padding: 12px; border-radius: 8px; text-align: center; }}
        .tier-1 {{ background: #ff4444; }}
        .tier-2 {{ background: #ffaa00; }}
        .tier-3 {{ background: #00aa44; }}
        .status {{ display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }}
        .status-ready {{ background: #00aa44; color: #000; }}
        .status-pending {{ background: #ffaa00; color: #000; }}
        .status-standby {{ background: #444; }}
        .launch-timer {{
            background: linear-gradient(135deg, #ff4444 0%, #ff8800 100%);
            padding: 24px;
            border-radius: 12px;
            text-align: center;
            margin-top: 20px;
        }}
        .launch-timer h2 {{ margin-bottom: 8px; }}
        table {{ width: 100%; border-collapse: collapse; margin-top: 16px; }}
        th, td {{ text-align: left; padding: 12px; border-bottom: 1px solid #333; }}
        th {{ color: #888; font-weight: 500; }}
        tr:hover {{ background: #222; }}
        .sync-time {{ color: #666; font-size: 12px; margin-top: 20px; text-align: right; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>🚛 IC_LOGISTICS Command Center</h1>
        <p>Commercial Kitchen Equipment Installation • Dealer Partnership Intelligence</p>
    </div>
    
    <div class="launch-timer">
        <h2>🚀 REBRAND LAUNCH: MONDAY FEBRUARY 23, 2025</h2>
        <p>All systems preparing for go-live. NO OUTREACH until launch.</p>
    </div>
    
    <div class="grid">
        <div class="card">
            <h3>📊 Total Dealer Targets</h3>
            <div class="metric">{targets.get('total_dealers', 0)}</div>
            <div class="label">Identified prospects</div>
            <div class="tier-bar">
                <div class="tier tier-1">T1: {tier1_count}</div>
                <div class="tier tier-2">T2: {tier2_count}</div>
                <div class="tier tier-3">T3: {tier3_count}</div>
            </div>
        </div>
        
        <div class="card">
            <h3>👤 Operations Manager Intel</h3>
            <div class="metric">{total_contacts}</div>
            <div class="label">Contacts with LinkedIn profiles</div>
            <div style="margin-top: 12px;">
                <span class="status status-pending">Enrichment Pending</span>
            </div>
        </div>
        
        <div class="card">
            <h3>📧 Outreach Queue</h3>
            <div class="metric small">LOCKED</div>
            <div class="label">Emails queued for Monday launch</div>
            <div style="margin-top: 12px;">
                <span class="status status-standby">STANDBY</span>
            </div>
        </div>
        
        <div class="card">
            <h3>✅ Launch Readiness</h3>
            <div class="metric small" style="color: #ffaa00;">85%</div>
            <div class="label">Pre-launch checklist</div>
            <div style="margin-top: 12px; font-size: 13px; color: #888;">
                ✓ Dealer list compiled<br>
                ✓ Intel gathering active<br>
                ⏳ Email templates final review<br>
                ✗ Outreach (post-launch only)
            </div>
        </div>
    </div>
    
    <div class="card">
        <h3>🎯 Priority Targets (Tier 1)</h3>
        <table>
            <tr>
                <th>Dealer</th>
                <th>Region</th>
                <th>Est. Size</th>
                <th>Specialty</th>
                <th>Status</th>
            </tr>
"""
    
    for dealer in targets.get('priority_tiers', {}).get('tier_1', [])[:5]:
        html += f"""
            <tr>
                <td><strong>{dealer.get('name', 'Unknown')}</strong></td>
                <td>{dealer.get('region', 'N/A')}</td>
                <td>{dealer.get('est_size', 'N/A')}</td>
                <td>{dealer.get('specialty', 'N/A').replace('_', ' ').title()}</td>
                <td><span class="status status-ready">Ready</span></td>
            </tr>
"""
    
    html += f"""
        </table>
    </div>
    
    <div class="card">
        <h3>👔 Key Contacts Identified</h3>
        <table>
            <tr>
                <th>Name</th>
                <th>Dealer</th>
                <th>Title</th>
                <th>LinkedIn</th>
            </tr>
"""
    
    for contact in intel.get('operations_managers', [])[:8]:
        html += f"""
            <tr>
                <td>{contact.get('name', 'Unknown')}</td>
                <td>{contact.get('dealer', 'N/A')}</td>
                <td>{contact.get('title', 'N/A')}</td>
                <td><a href="https://{contact.get('linkedin', '#')}" style="color: #00d4ff;">View Profile</a></td>
            </tr>
"""
    
    html += f"""
        </table>
    </div>
    
    <div class="sync-time">Last synced: {datetime.now().strftime('%Y-%m-%d %H:%M:%S PST')}</div>
</body>
</html>
"""
    return html

def main():
    print("[DASHBOARD] Syncing Command Center...")
    
    # Load all data sources
    targets = load_json('marketing/dealer_targets.json')
    intel = load_json('marketing/intel_cache.json')
    state = load_json('marketing/dashboard_state.json')
    
    # Generate HTML dashboard
    html = generate_html(targets, intel, state)
    
    # Update sync time in HTML to now
    from datetime import datetime
    html = html.replace(
        'Last synced: 2025-02-22 16:49:00 PST',
        f"Last synced: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} PST"
    )
    
    with open('marketing/command_center.html', 'w', encoding='utf-8') as f:
        f.write(html)
    
    # Update state
    state['last_sync'] = datetime.now().isoformat()
    state.setdefault('modules', {})
    state['modules'].setdefault('target_pipeline', {})
    state['modules'].setdefault('intel_recon', {})
    state['modules']['target_pipeline']['count'] = targets.get('total_dealers', 0)
    state['modules']['intel_recon']['count'] = intel.get('total_contacts', 0)
    
    with open('marketing/dashboard_state.json', 'w') as f:
        json.dump(state, f, indent=2)
    
    print(f"[DASHBOARD] Command Center updated: file:///C:/Users/alexb/.openclaw/workspace/marketing/command_center.html")
    print(f"[DASHBOARD] Targets: {targets.get('total_dealers', 0)} | Contacts: {intel.get('total_contacts', 0)}")

if __name__ == "__main__":
    main()
