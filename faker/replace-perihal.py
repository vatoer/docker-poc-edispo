import pymysql
from faker import Faker

def update_perihal_berita():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='password',
        database='poc_db_edisposisi'
    )

    faker = Faker()

    try:
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT arsip_kd FROM tbl_berita")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                arsip_kd = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_berita SET perihal_berita = %s, berita_kd = %s  WHERE arsip_kd = %s", (fake_perihal,fake_nomor_surat, arsip_kd))
                print(f'Updated perihal_berita for arsip_kd: {arsip_kd}')

            connection.commit()
            
            cursor.execute("SELECT perwakilan_kd FROM tbl_perwakilan")
            rows = cursor.fetchall()
            
            for row in rows:
                perwakilan_kd = row[0]
                fake_city = faker.city()
                cursor.execute("UPDATE tbl_perwakilan SET perwakilan_nama = %s where perwakilan_kd = %s", (fake_city, perwakilan_kd))
                print(f'Updated perwakilan_nama for perwakilan_kd: {perwakilan_kd}')
            connection.commit()
            
            print('All records have been updated.')
    except Exception as e:
        print(f'An error occurred: {e}')
    finally:
        connection.close()

if __name__ == '__main__':
    update_perihal_berita()
