import re

old_url = "http://cloud-3.steamusercontent.com/ugc/"
new_url = "https://steamusercontent-a.akamaihd.net/ugc/"

def fix_links_in_text(text):
    old_content = text
    new_text = re.sub(old_url, new_url, old_content)
    return new_text
