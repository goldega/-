use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
fn count_lines(file_path: &str) -> io::Result<usize> {
    // Відкриваємо файл
    let file = File::open(file_path)?;
    
    // Створюємо буферизований ридер для читання файлу
    let reader = io::BufReader::new(file);
    
    // Ініціалізуємо лічильник рядків
    let mut line_count = 0;
    
    // Читаємо кожен рядок з файлу
    for _line in reader.lines() {
        line_count += 1;
    }
    
    // Повертаємо кількість рядків
    Ok(line_count)
}

fn main() {
    let file_path = "file.txt"; // Вказуємо шлях до файлу
    
    // Викликаємо функцію для підрахунку рядків
    match count_lines(file_path) {
        Ok(count) => println!("Кількість рядків у файлі: {}", count),
        Err(e) => println!("Помилка при відкритті файлу: {}", e),
    }
}
