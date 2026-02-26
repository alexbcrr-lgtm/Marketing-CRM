import os
import subprocess
import time

def continuous_improvement():
    print("🔋 INITIALIZING CRM AUTOPILOT...")
    
    scripts = [
        'C:/Users/alexb/.openclaw/workspace/marketing/lead_hunter.py',
        'C:/Users/alexb/.openclaw/workspace/marketing/recon_engine.py',
        'C:/Users/alexb/.openclaw/workspace/marketing/sync_dashboard.py'
    ]

    for script in scripts:
        if os.path.exists(script):
            print(f"▶ EXECUTING: {os.path.basename(script)}")
            try:
                subprocess.run(['python', script], check=True)
            except Exception as e:
                print(f"❌ Error in {script}: {e}")
        time.sleep(2)

    print("🏁 CYCLE COMPLETE. COMMAND CENTER SYNCHRONIZED.")

if __name__ == "__main__":
    continuous_improvement()
