
import pathlib
import time
import PySimpleGUI as sg
from pythonosc import udp_client


if __name__ == '__main__':
    
    
    # we know it's MacLocal so use know ipaddress
    mha_ipaddress = '127.0.0.1'
    mha_osc_port = 7779
    # if not util.is_valid_ipaddress(mha_ipaddress):
#         raise ValueError("IP address")
    
    # osc stuff - needs to match cfg file contents (osc2ac.vars)
    msg_address = '/bfsteer/doa_index'
    doa_at_index_0 = -180
    doa_increment = 5
    
    mha_osc = udp_client.SimpleUDPClient(mha_ipaddress, mha_osc_port)
    
	# build gui
    layout = [[sg.Text('Enter steering direction index')],
              [sg.Text('Index (int)'), sg.InputText(key='-INPUT-')],
							[sg.Text('Angle [deg]', key='-DISPLAY-')],
              [sg.Button('Send')]]
    
    window = sg.Window('Beemsteerer', layout)

    while True:  # Event Loop
        event, values = window.read()
        print(event, values)
        if event == sg.WIN_CLOSED:
            break
        if event == 'Send':
            # Make sure the entered value is a integer
            entered_val = values['-INPUT-']
            float_val = float(entered_val)
            mha_osc.send_message(msg_address, [float_val])
            doa_deg = doa_at_index_0 + float_val * doa_increment
            window['-DISPLAY-'].update(f'{doa_deg}')

    window.close()
		