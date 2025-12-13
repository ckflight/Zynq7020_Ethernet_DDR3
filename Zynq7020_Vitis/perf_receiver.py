import socket
import time
import struct

ZYNQ_IP = "192.168.1.10"
ZYNQ_PORT = 5001          # TCP_CONN_PORT
BUF_SIZE = 64 * 1024      # 64 KB recv buffer

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 4 * 1024 * 1024)
    sock.connect((ZYNQ_IP, ZYNQ_PORT))

    print("Connected to Zynq")

    total_bytes = 0
    start_time = time.time()
    last_print = start_time

    expected = None  # for optional pattern check

    try:
        while True:
            data = sock.recv(BUF_SIZE)
            if not data:
                print("Connection closed by server")
                break

            total_bytes += len(data)

            # OPTIONAL: sanity check incrementing u32 pattern
            if len(data) >= 4:
                words = struct.iter_unpack("<I", data)
                for (val,) in words:
                    if expected is None:
                        expected = val + 1
                    else:
                        if val != expected:
                            print(f"Pattern error! got {val}, expected {expected}")
                            expected = val + 1
                        else:
                            expected += 1

            now = time.time()
            if now - last_print >= 1.0:
                elapsed = now - start_time
                mbps = (total_bytes * 8) / (elapsed * 1e6)
                print(f"RX: {mbps:.1f} Mbps")
                last_print = now

    except KeyboardInterrupt:
        print("Stopped by user")

    finally:
        sock.close()
        elapsed = time.time() - start_time
        mbps = (total_bytes * 8) / (elapsed * 1e6)
        print(f"\nFinal RX: {mbps:.1f} Mbps")

if __name__ == "__main__":
    main()
