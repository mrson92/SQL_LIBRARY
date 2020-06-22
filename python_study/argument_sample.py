import argparse

def main(filename_list, option_list, auth_id_list):
    print('Target File : {}'.format(filename_list))
    print('Optional : {}'.format(option_list))
    print('Auth_id : {}'.format(auth_id_list))

def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument(nargs=1 ,help='Example) 20200421.log', dest='filename')
    parser.add_argument('-o', nargs=1, help='Example) find, list, subject', default=[], dest='option')
    parser.add_argument('-i', nargs=1, help='Example) auth_id@domain', default=[], dest='auth_id')

    filename_list = parser.parse_args().filename
    option_list = parser.parse_args().option
    auth_id_list = parser.parse_args().auth_id

    return filename_list, option_list, auth_id_list

if __name__ == '__main__':
    filename_list, option_list,auth_id_list = get_arguments()
    main(filename_list, option_list,auth_id_list)
