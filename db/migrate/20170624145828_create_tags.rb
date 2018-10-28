class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :code
      t.string :description
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO tags (code, name, description) VALUES('MY_TRA', 'MOJE PODRÓŻE', 'Audycje z osobistymi relacjami z podróży');
          INSERT INTO tags (code, name, description) VALUES('TRIVIA', 'CIEKAWOSTKI', 'Powinieneś przesłuchać, jeśli niedługo wybierasz się na wakacje');
          INSERT INTO tags (code, name, description) VALUES('ASTRO', 'ASTRONOMIA', 'Kosmiczna muzyka i podróże poza Ziemię');
          INSERT INTO tags (code, name, description) VALUES('MUSFRO', 'MUZYKA Z...', 'W tych odcinkach dominowała muzyka danego regionu...');
          INSERT INTO tags (code, name, description) VALUES('THEME', 'MOTYW PRZEWODNI', 'Audycje z motywem przewodnim - luźno związanym z podróżami');
          INSERT INTO tags (code, name, description) VALUES('SPECIAL', 'OKOLICZNOŚCIOWE', 'Odcinki specjalne na święta, rocznice i inne okazje specjalne');
          INSERT INTO tags (code, name, description) VALUES('CYCLE', 'CYKL', 'Te audycje były częścią kilkuodcinkowych cykli');
          INSERT INTO tags (code, name, description) VALUES('CONCERT', 'RELACJA Z', 'Relacja z koncertu');
          INSERT INTO tags (code, name, description) VALUES('SET', 'SET', 'Set muzyczny');
        SQL
      end
      dir.down do
        execute <<-SQL
          DELETE FROM tags WHERE name='MOJE PODRÓŻE';
          DELETE FROM tags WHERE name='CIEKAWOSTKI';
          DELETE FROM tags WHERE name='ASTRONOMIA';
          DELETE FROM tags WHERE name='MUZYKA Z...';
          DELETE FROM tags WHERE name='MOTYW PRZEWODNI';
          DELETE FROM tags WHERE name='OKOLICZNOŚCIOWE';
          DELETE FROM tags WHERE name='CYKL';
          DELETE FROM tags WHERE name='RELACJA Z';
          DELETE FROM tags WHERE name='SET';
        SQL
      end
    end

  end
end
