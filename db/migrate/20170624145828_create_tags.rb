class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :description
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO tags (name, description) VALUES('MOJE PODRÓŻE', 'Audycje z osobistymi relacjami z podróży');
          INSERT INTO tags (name, description) VALUES('CIEKAWOSTKI', 'Powinieneś przesłuchać, jeśli niedługo wybierasz się na wakacje');
          INSERT INTO tags (name, description) VALUES('ASTRONOMIA', 'Kosmiczna muzyka i podróże poza Ziemię');
          INSERT INTO tags (name, description) VALUES('MUZYKA Z...', 'W tych odcinkach dominowała muzyka danego regionu...');
          INSERT INTO tags (name, description) VALUES('MOTYW PRZEWODNI', 'Audycje z motywem przewodnim - luźno związanym z podróżami');
          INSERT INTO tags (name, description) VALUES('OKOLICZNOŚCIOWE', 'Odcinki specjalne na święta, rocznice i inne okazje specjalne');
          INSERT INTO tags (name, description) VALUES('CYKL', 'Te audycje były częścią kilkuodcinkowych cykli');
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
        SQL
      end
    end

  end
end