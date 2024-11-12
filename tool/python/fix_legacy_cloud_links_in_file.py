from select_text_file import open_file_explorer_and_select
from legacy_cloud_link_to_new import fix_links_in_text

def read_file_content(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()
    return content

def save_file(file_path, content):
    with open(file_path, "w", encoding="utf-8") as file:
        file.write(content)

def main():
    selected_file = open_file_explorer_and_select()
    file_content = read_file_content(selected_file)

    if selected_file:
        fixed_content = fix_links_in_text(file_content)
        save_file(selected_file, fixed_content)

if __name__ == "__main__":
    main()
