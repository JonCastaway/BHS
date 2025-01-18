name: Update README with Server Status
on:
  schedule:
    - cron: '0 * * * *' # This runs the script every hour
  workflow_dispatch: # Allows manual trigger

jobs:
  update-status:
    runs-on: ubuntu-latest
    steps:
      - name: Check out the repository
        uses: actions/checkout@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install requests

      - name: Run the status update script
        run: |
          python check_server_status.py

      - name: Commit and push changes
        env:
          GH_TOKEN: ${{ secrets.GH_TOKEN }}
        run: |
          git config --global user.name 'github-actions'
          git config --global user.email 'github-actions@github.com'
          git add "README.md"
          git commit -m "Update README with server status"
          git remote set-url origin https://${{ github.actor }}:${{ secrets.GH_TOKEN }}@github.com/${{ github.repository }}.git
          git push https://${{ github.actor }}:${{ secrets.GH_TOKEN }}@github.com/${{ github.repository }}.git HEAD:main
