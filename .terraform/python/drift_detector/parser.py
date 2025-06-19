import json
import subprocess

def load_terraform_state():
    try:
        result = subprocess.run(["terraform", "show", "-json"], capture_output=True, check=True)
        state = json.loads(result.stdout)

        resources = []
        for res in state.get("values", {}).get("root_module", {}).get("resources", []):
            if res["type"] == "aws_instance":
                resources.append(res)

        return resources
    except Exception as e:
        print(f"Error reading Terraform state: {e}")
        return []
