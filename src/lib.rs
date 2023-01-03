use nostr::{Event, EventBuilder, Metadata, Keys, Result};
use nostr::message::ClientMessage;
use nostr::url::Url;
use tungstenite::{Message as WsMessage};

#[no_mangle]
pub extern fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() -> Result<()> {
    // Generate new random keys
    let my_keys = Keys::generate_from_os_random();

    // or use your already existing
    //
    // From HEX or Bech32
    // use nostr::key::FromSkStr;
    // let my_keys = Keys::from_sk_str("hex-or-bech32-secret-key")?;

    // Show bech32 public key
    use nostr::util::nips::nip19::ToBech32;
    let bech32_pubkey: String = my_keys.public_key().to_bech32()?;
    println!("Bech32 PubKey: {}", bech32_pubkey);

    let metadata = Metadata::new()
        .name("username")
        .display_name("My Username")
        .about("Description")
        .picture(Url::parse("https://example.com/avatar.png")?)
        .nip05("username@example.com")
        .lud16("yuki@stacker.news");

    let event: Event = EventBuilder::set_metadata(metadata)?.to_event(&my_keys)?;

    // New text note
    let event: Event = EventBuilder::new_text_note("Hello from Nostr SDK", &[]).to_event(&my_keys)?;

    // New POW text note
    let event: Event = EventBuilder::new_text_note("My first POW text note from Nostr SDK", &[]).to_pow_event(&my_keys, 20)?;

    // Connect to relay
    let (mut socket, _) = tungstenite::connect(Url::parse("wss://relay.damus.io")?).expect("Can't connect to relay");

    // Send msg
    let msg = ClientMessage::new_event(event).as_json();
    socket.write_message(WsMessage::Text(msg)).expect("Impossible to send message");

    Ok(())
}