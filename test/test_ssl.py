# Databricks notebook source
import requests


def request_ok(url, **kwargs):
  try:
    return requests.get(url, **kwargs).ok
  except Exception:
    return False


def test_ssl():
  links = '''https://cartodb.com/
  https://environment.data.gov.uk/
  https://server.arcgisonline.com/
  https://data.gov.uk/
  https://api.os.uk/
  https://osdatahub.os.uk/
  https://download.geofabrik.de/
  https://openstreetmap.org/
  https://overpass-api.de/
  https://dataspace.copernicus.eu/'''.split()

  results = {
    'https://sha256.badssl.com/': request_ok('https://sha256.badssl.com/'),
    'https://expired.badssl.com/': not request_ok('https://expired.badssl.com/'),
    **{link: request_ok(link) for link in links},
  }
  assert all(results.values()), results
  return results


test_ssl()
