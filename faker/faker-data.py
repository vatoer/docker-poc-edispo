import pymysql
from faker import Faker

# docker 
def update_perihal_berita():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='root',
        database='db_edisposisi',
        port=3307
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

            cursor.execute("SELECT arsip_kd,sifat_kd FROM tbl_berita_keluar")
            rows = cursor.fetchall()
            
            for row in rows:
                arsip_kd = row[0]
                sifat_kd = row[1]
                # Determine the prefix based on sifat_kd
                if sifat_kd == 1:
                    prefix = "R-"
                else:
                    prefix = "B-"
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                fake_nomor_surat = prefix + fake_nomor_surat
                cursor.execute("UPDATE tbl_berita_keluar SET perihal_berita = %s, berita_kd = %s  WHERE arsip_kd = %s", (fake_perihal,fake_nomor_surat, arsip_kd))
                print(f'Updated tbl_berita_keluar for arsip_kd: {arsip_kd}')

            connection.commit()
            
            print('All records have been updated.')
    except Exception as e:
        print(f'An error occurred: {e}')
    finally:
        connection.close()

# docker 
def update_penomoran():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='root',
        database='db_penomoran',
        port=3307
    )

    faker = Faker()

    try:
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_bapk")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_bapk SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_bapk for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_keluar")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                fake_tujuan = f"{faker.address()}"
                cursor.execute("UPDATE tbl_keluar SET isi_surat = %s, tujuan = %s  WHERE id = %s", (fake_perihal,fake_tujuan, id))
                print(f'Updated tbl_keluar for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_keputusan")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_keputusan SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_keputusan for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_keterangan")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                fake_kepada = f"{faker.name()}"
                cursor.execute("UPDATE tbl_keterangan SET perihal = %s, kepada = %s  WHERE id = %s", (fake_perihal,fake_kepada, id))
                print(f'Updated tbl_keterangan for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_nota")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_nota SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_nota for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_notadiplomatik")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_notadiplomatik SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_notadiplomatik for id: {id}')

            connection.commit()
        
        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_sppd")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_sppd SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_sppd for id: {id}')

            connection.commit()

        with connection.cursor() as cursor:
            # Fetch all records
            cursor.execute("SELECT id FROM tbl_tugas")
            rows = cursor.fetchall()

            # Loop through all records and update perihal_berita with fake data
            for row in rows:
                id = row[0]
                fake_perihal = faker.paragraph(nb_sentences=3, variable_nb_sentences=True, ext_word_list=None)
                # fake_nomor_surat = f"{faker.unique.random_number(digits=5, fix_len=True)}/{faker.city_suffix()}/{faker.month()}/{faker.year()}"
                cursor.execute("UPDATE tbl_tugas SET perihal = %s  WHERE id = %s", (fake_perihal, id))
                print(f'Updated tbl_tugas for id: {id}')

            connection.commit()


    except Exception as e:
        print(f'An error occurred: {e}')
    finally:
        connection.close()

if __name__ == '__main__':
    # update_perihal_berita()
    update_penomoran()

