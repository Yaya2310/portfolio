import os

replacements = {
    'Ã©': 'é',
    'Ã ': 'à',
    'Ã¨': 'è',
    'Ã¹': 'ù',
    'Ã®': 'î',
    'Ã»': 'û',
    'Ã¢': 'â',
    'Ãª': 'ê',
    'Ã´': 'ô',
    'Ã§': 'ç',
    'Ã‰': 'É',
    'Ã€': 'À',
    'Ãˆ': 'È',
    'Ã¯': 'ï',
    'Ã«': 'ë',
    'Ãœ': 'Ü',
    'Ã¶': 'ö',
    'Ã¤': 'ä',
    'â€™': '’',
    'Ã«': 'ë',
    'Ã¹': 'ù',
    'Ã\xa0': 'à', # Non-breaking space
    'Ã\x89': 'É',
    'Ã\x80': 'À',
    'Ã\x88': 'È',
    'Ã\x81': 'Á',
    'Ã¢': 'â',
    'Ãª': 'ê',
    'Ã®': 'î',
    'Ã´': 'ô',
    'Ã»': 'û',
}

def fix_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = content
        for old, new in replacements.items():
            new_content = new_content.replace(old, new)
        
        if new_content != content:
            with open(filepath, 'w', encoding='utf-8', newline='') as f:
                f.write(new_content)
            print(f"Fixed: {filepath}")
    except Exception as e:
        print(f"Error fixing {filepath}: {e}")

for filename in os.listdir('.'):
    if filename.endswith('.html'):
        fix_file(filename)
