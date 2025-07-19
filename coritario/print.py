import json
from reportlab.lib.pagesizes import letter
from reportlab.lib.pagesizes import A5
from reportlab.pdfgen import canvas
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics
import os

# Function to load songs from a JSON file
def load_songs_from_json(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        data = json.load(file)
        return data["songs"]

def select_song(songs):
    print("Available songs:")
    for song in songs:
        print(f"{song['number']}. {song['title']}")
    song_number = int(input("Enter the song number to select: "))
    selected_song = next((song for song in songs if song["number"] == song_number), None)
    return selected_song


def sanitize_title(title):
    # Replace invalid characters with underscores
    sanitized_title = title.replace(':', '_')
    return sanitized_title

def generate_pdf(sizeFont, song, font_path, include_chords=False):
    
    output_folder = 'output'
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
        
    # Sanitize the title for use as filename
    sanitized_title = sanitize_title(song['title'])
    filename = f"{output_folder}/{sanitized_title}.pdf"
    
    #filename = f"output/{song['title']}.pdf"
    
    #c = canvas.Canvas(filename, pagesize=letter)
    #width, height = letter
    c = canvas.Canvas(filename, pagesize=A5)
    width, height = A5

    # Register the custom font
    pdfmetrics.registerFont(TTFont('MartianMono', font_path))
    c.setFont("MartianMono", sizeFont)

    text = c.beginText(40, height - 40)
    text.setTextOrigin(40, height - 40)

    title = f"{song['title']}"
    text.textLine(title)
    text.textLine("")
    
    
    lyrics = song["lyrics_with_chords"] if include_chords else song["lyrics_without_chords"]
    for line in lyrics.split('\n'):
        text.textLine(line)
    
    c.drawText(text)
    c.showPage()
    c.save()
    print(f"PDF generated: {filename}")

def main():
    file_path = 'assets/lyrics.json'  # Path to the JSON file
    font_path = 'assets/MartianMonoNerdFontMono-Regular.ttf'  # Path to the font file
    songs = load_songs_from_json(file_path)
    selected_song = select_song(songs)
    if selected_song:
        include_chords = input("Include chords in the lyrics? (y/n): ").strip().lower() == 'y'
        sizeFont = int(input("Font size: "))
        generate_pdf(sizeFont,selected_song, font_path, include_chords)
    else:
        print("Song not found.")

if __name__ == "__main__":
    main()
