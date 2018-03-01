import requests
import csv
import sys

def get_last_data_id():
    response = requests.get("https://bitbay.net/API/Public/BTCPLN/market.json")
    market_data = response.json()
    last_tid = int(market_data['transactions'][0]['tid'])
    return last_tid

def refresh(new_first_tid):
    trans_list =[]
    last_tid = get_last_data_id()

    #or from_id to id_aim
    id_aim = last_tid
    from_id = new_first_tid

    n = id_aim - from_id
    n_for = int(n/50)

    for i in range(n_for + 1):
        id_tran = from_id + i*50
        
        URL = "https://bitbay.net/API/Public/BTCPLN/trades.json?since=" + str(id_tran)
        response = requests.get(URL)

        # Print the status code of the response.
        print(response.status_code)
        print(id_tran)

        data = response.json()
        
        for element in data:
            #date - czas transakcji jako unix timestamp
            temp = [element['tid'], element['amount'], element['price'], element['type'], element['date']]
            trans_list.append(temp)
            if element['tid'] == str(last_tid):
                break
        
        if element['tid'] == str(last_tid):
            break
        if data == []:
            break

        #print(i)

    csv_out_name = "example_data/data_raw_bitbay.csv"
    with open(csv_out_name, "a") as f:
        writer = csv.writer(f)
        writer.writerows(trans_list)
    return 1

if __name__ == '__main__':
    x = int(sys.argv[1])
    out = refresh(x)
    sys.stdout.write('data updated')
