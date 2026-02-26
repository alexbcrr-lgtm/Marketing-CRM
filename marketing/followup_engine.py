import json
from datetime import datetime

# Configuration
CRM_FILE = 'marketing/crm-site/VECTOR_CRM_DATA_V2.json'
CURRENT_DATE = datetime(2026, 2, 24)

def calculate_days(last_date_str):
    if not last_date_str:
        return 0
    last_date = datetime.strptime(last_date_str, '%Y-%m-%d')
    return (CURRENT_DATE - last_date).days

def process_followups():
    with open(CRM_FILE, 'r') as f:
        data = json.load(f)

    updates = []
    queued_emails = []

    for target in data:
        # Check if reply received - skip if yes
        if target.get('reply_received'):
            continue
        
        phase = target.get('phase')
        touches = target.get('touches', {})
        days_since = calculate_days(target.get('last_touch_date'))

        # Rule 1: Touch 1 -> Touch 2 (>= 3 days)
        if phase == 'touch1' and touches.get('t1') and days_since >= 3:
            target['phase'] = 'touch2'
            target['next_action'] = 'Queue T2 Email'
            updates.append(f"ADVANCE: {target['company']} (T1 -> T2, {days_since} days)")
            queued_emails.append({
                "to": target['email'],
                "template": f"{target['brand']}_t2",
                "company": target['company']
            })

        # Rule 2: Touch 2 -> Touch 3 (>= 4 days)
        elif phase == 'touch2' and touches.get('t2') and days_since >= 4:
            target['phase'] = 'touch3'
            target['next_action'] = 'Queue T3 Email'
            updates.append(f"ADVANCE: {target['company']} (T2 -> T3, {days_since} days)")
            queued_emails.append({
                "to": target['email'],
                "template": f"{target['brand']}_t3",
                "company": target['company']
            })

        # Rule 3: Touch 3 -> Lost (>= 7 days)
        elif phase == 'touch3' and touches.get('t3') and days_since >= 7:
            target['phase'] = 'lost'
            target['status'] = 'lost'
            target['next_action'] = 'Archive'
            updates.append(f"LOST: {target['company']} (T3 expired, {days_since} days)")

    # Save updated JSON
    with open(CRM_FILE, 'w') as f:
        json.dump(data, f, indent=2)

    return updates, queued_emails

if __name__ == "__main__":
    updates, queued = process_followups()
    print("--- PHASE CHANGES ---")
    for u in updates:
        print(u)
    print("\n--- QUEUED EMAILS ---")
    for q in queued:
        print(f"To: {q['to']} | Template: {q['template']} | Company: {q['company']}")
