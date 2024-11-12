import tkinter as tk
from tkinter import filedialog

def open_file_explorer_and_select():
    root = tk.Tk()
    root.withdraw()

    file_path = filedialog.askopenfilename(
        title='Select Text file',
    filetypes=(
        ("Text Files", "*.txt"),
        ("Json Files", "*.json"),
        ("All files", "*.*")
    ))

    if file_path:
        return file_path
    else:
        return None
