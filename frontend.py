import psycopg2
import os


def login():

    conn = psycopg2.connect(user = 'postgres' , password = '4121' , database = 'social_media')
    cur = conn.cursor()


    print("*********************welcome to social_media ui********************")
    print("enter login detils")
    uname = input("enter the username: ")
    passwd = input("enter the password: ")

    cur.callproc('check_user_exists',(uname,passwd))


    uid = cur.fetchone()

    cur.close()
    conn.close()
    
    if uid[0] == None:
        print("user doesnt exist")
        exit()
    else:
        return uid[0]


def upload_photo(uid):
    os.system('cls')
    conn = psycopg2.connect(user = 'postgres' , password = '4121' , database = 'social_media')
    cur = conn.cursor()


    photo_link = input("enter the photos link: ")
    caption = input("enter the photos caption: ")

    cur.callproc('insert_photo',(uid,photo_link,caption))
    conn.commit()

    cur.close()
    conn.close()


def delete_testimonial(uid):

    os.system('cls')
    conn = psycopg2.connect(user = 'postgres' , password = '4121' , database = 'social_media')
    cur = conn.cursor()

    tid = int(input("enter the testimonial id you want to delete"))

    cur.execute('delete from testimonial where tr_id = %d' %tid)
    conn.commit()

    print("scrap was updated")
    
    cur.close()
    conn.close()

def check_friend_status(uid):
    os.system('cls')
    conn = psycopg2.connect(user = 'postgres' , password = '4121' , database = 'social_media')
    cur = conn.cursor()

    cur.callproc('select f_mail,approval_status from friends where user_id = %d'%uid)

    print("your friends and their approval status are as follows: \n",cur.fetchall())

    cur.close()
    conn.close()


def mainpage(uid):
    os.system('cls')
    ch = 0
    while ch != 4:

        print("1: upload a photo")
        print("2: delete a testimonial")
        print('3: check your friends and their status')
        print('4: exit')

        ch = int(input("enter your choice: "))

        if ch == 1:
            upload_photo(uid)
        elif ch == 2:
            if uid == 4121:
                delete_testimonial(uid)

            else:
                print("you are not authorised to delete testimonials, only admin can delete them")
        elif ch == 3:
            check_friend_status(uid)
        elif ch == 4:
            exit()
        else:
            print("wrong choice try again")






uid = login()

mainpage(uid)